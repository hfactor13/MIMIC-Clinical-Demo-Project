from load_csvs import load_csv_files
from export_csvs import export_csv_files
import duckdb as db

def main():

    # Load mimic input data files into a database
    load_csv_files()
    
    # Function loads the query before execution
    def load_query(query_name):
        with open(query_name, "r") as query:
            create_table_query = query.readlines()
        return create_table_query

    # Load the create_patients_table.sql query
    patients_table_query = load_query("create_patients_table.sql")

    # Load the create_procedures_table.sql query
    procedures_table_query = load_query("create_procedures_table.sql")

    # Execute the sql queries
    with db.connect("mimic-clinical-demo.db", "r") as con:
        con.execute(patients_table_query)
        con.execute(procedures_table_query)

    # Export the resultant tables from the SQL queries to CSV for import into a BI visualization tool
    export_csv_files()

if __name__ == "__main__":
    main()