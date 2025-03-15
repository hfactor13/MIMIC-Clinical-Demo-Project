def load_csv_files():
    # This script loads CSV files into tables in a duckdb database
    from pathlib import Path
    import duckdb as db

    # Defines the working directory and gets all the CSV files
    working_dir = Path.cwd() / "mimic-clinical-demo"
    csv_file_path = list(working_dir.glob("*.csv"))
    csv_file_path

    # Get the table names
    db_table_names = [file.stem.lower() for file in csv_file_path]
    db_table_names

    # Defines the duckdb database and saves all the CSVs to the database as separate tables
    con = db.connect("mimic-clinical-demo.db")
    for table, file_path in zip(db_table_names, csv_file_path):
        with db.connect("mimic-clinical-demo.db") as con:
            con.execute(f"""CREATE OR REPLACE TABLE {table} AS 
                        SELECT * FROM read_csv('{file_path}', delim=',', header=True, quote='"', escape='"', ignore_errors=True); """)

if __name__ == "__main__":
    load_csv_files()