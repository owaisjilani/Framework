import csv


def read_csv_file(filename):
    data = []
    with open(filename, 'rt') as csvfile:
        reader = csv.reader(csvfile, delimiter='|')
        next(reader)
        for row in reader:
            data.append(row)
    return data


def get_total_rows(csv_file_path):
    with open(csv_file_path, 'r', newline='') as file:
        reader = csv.reader(file)
        next(reader)
        total_rows = sum(1 for row in reader)
    return total_rows

