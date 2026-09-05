#!/usr/bin/env python3
"""Register a paper PDF into the Jaykim-org archive.

Extracts full text with pypdf, stores a ``.txt`` sidecar next to the PDF, and
appends/updates a metadata record in ``papers/index.json``.

Example
-------
    python Jaykim-org/tools/ingest_paper.py paper.pdf \
        --title "..." --authors "Hong S, Han B, Nam J" --journal "J Biomed Eng Res" \
        --year 2026 --doi 10.9718/JBER.2026.47.4.268 --tags 3d-printing,PCL
"""
from __future__ import annotations

import argparse
import json
import logging
import shutil
import sys
from dataclasses import asdict, dataclass, field
from datetime import date
from pathlib import Path
from typing import Any

try:
    from pypdf import PdfReader
except ImportError as exc:  # pragma: no cover - environment guard
    sys.exit(f"pypdf is required: pip install pypdf ({exc})")

ARCHIVE_ROOT = Path(__file__).resolve().parent.parent
PAPERS_DIR = ARCHIVE_ROOT / "papers"
INDEX_PATH = PAPERS_DIR / "index.json"

logger = logging.getLogger("ingest_paper")


@dataclass
class PaperRecord:
    """Metadata stored for each archived paper."""

    id: str
    title: str
    authors: list[str]
    journal: str
    year: int
    doi: str | None
    pdf: str
    text: str
    tags: list[str] = field(default_factory=list)
    added: str = field(default_factory=lambda: date.today().isoformat())
    n_pages: int = 0
    analysis: str | None = None


def extract_text(pdf_path: Path) -> tuple[str, int]:
    """Return concatenated page text and page count.

    Pages that fail to decode are recorded as empty rather than aborting the run.
    """
    reader = PdfReader(str(pdf_path))
    chunks: list[str] = []
    for i, page in enumerate(reader.pages, start=1):
        try:
            body = page.extract_text() or ""
        except Exception as exc:  # noqa: BLE001 - pypdf raises many types
            logger.warning("page %d: text extraction failed (%s)", i, exc)
            body = ""
        chunks.append(f"===== PAGE {i} =====\n{body}")
    return "\n".join(chunks), len(reader.pages)


def load_index() -> list[dict[str, Any]]:
    if not INDEX_PATH.exists():
        return []
    with INDEX_PATH.open(encoding="utf-8") as fh:
        return json.load(fh)


def save_index(records: list[dict[str, Any]]) -> None:
    INDEX_PATH.parent.mkdir(parents=True, exist_ok=True)
    with INDEX_PATH.open("w", encoding="utf-8") as fh:
        json.dump(records, fh, ensure_ascii=False, indent=2)
        fh.write("\n")


def build_id(year: int, authors: list[str], journal: str) -> str:
    first = authors[0].split()[0] if authors else "Unknown"
    journal_key = "".join(w[0] for w in journal.split() if w[0].isalpha()).upper()
    return f"{year}_{first}_{journal_key}"


def ingest(args: argparse.Namespace) -> PaperRecord:
    src = Path(args.pdf).expanduser().resolve()
    if not src.is_file():
        raise FileNotFoundError(src)

    authors = [a.strip() for a in args.authors.split(",") if a.strip()]
    tags = [t.strip() for t in args.tags.split(",") if t.strip()] if args.tags else []
    record_id = args.id or build_id(args.year, authors, args.journal)

    PAPERS_DIR.mkdir(parents=True, exist_ok=True)
    dest_pdf = PAPERS_DIR / (args.filename or src.name)
    if src != dest_pdf:
        shutil.copy2(src, dest_pdf)
        logger.info("copied %s -> %s", src, dest_pdf)

    text, n_pages = extract_text(dest_pdf)
    dest_txt = dest_pdf.with_suffix(".txt")
    dest_txt.write_text(text, encoding="utf-8")

    record = PaperRecord(
        id=record_id,
        title=args.title,
        authors=authors,
        journal=args.journal,
        year=args.year,
        doi=args.doi,
        pdf=str(dest_pdf.relative_to(ARCHIVE_ROOT)),
        text=str(dest_txt.relative_to(ARCHIVE_ROOT)),
        tags=tags,
        n_pages=n_pages,
        analysis=args.analysis,
    )

    records = [r for r in load_index() if r.get("id") != record_id]
    records.append(asdict(record))
    records.sort(key=lambda r: (r["year"], r["id"]), reverse=True)
    save_index(records)
    logger.info("indexed %s (%d pages)", record_id, n_pages)
    return record


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("pdf", help="Path to the source PDF")
    p.add_argument("--title", required=True)
    p.add_argument("--authors", required=True, help="Comma-separated, e.g. 'Hong S, Han B, Nam J'")
    p.add_argument("--journal", required=True)
    p.add_argument("--year", required=True, type=int)
    p.add_argument("--doi", default=None)
    p.add_argument("--tags", default="", help="Comma-separated tags")
    p.add_argument("--id", default=None, help="Override record id (default: YEAR_FirstAuthor_JOURNAL)")
    p.add_argument("--filename", default=None, help="Rename the PDF inside papers/")
    p.add_argument("--analysis", default=None, help="Relative path to the analysis note")
    p.add_argument("-v", "--verbose", action="store_true")
    return p.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    logging.basicConfig(level=logging.DEBUG if args.verbose else logging.INFO, format="%(levelname)s %(message)s")
    try:
        ingest(args)
    except Exception as exc:  # noqa: BLE001
        logger.error("ingest failed: %s", exc)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
