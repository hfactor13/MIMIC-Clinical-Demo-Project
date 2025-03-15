def export_csv_files():
    from pathlib import Path
    import duckdb as db

    output_dir = Path.cwd() / "output"
    desired_tables = ["pat_tbl_combo", "proced_tbl_combo", "icustays"]

    with db.connect("mimic-clinical-demo.db") as con:
        for tbl_name in desired_tables:
            con.table(tbl_name).df().to_csv(output_dir / f"{tbl_name}.csv", sep = ",", index = False)


if __name__ == "__main__":
    export_csv_files()