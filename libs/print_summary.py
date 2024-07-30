import sys
import pandas as pd

def main(summary: str) -> None:

    csv = pd.read_csv(summary)
    print(csv.tail())

if len(sys.argv) != 2:
    raise SystemExit('Usage: print_summary.py <csv_path>')
else:
    summary = sys.argv[1]
    main(summary)
