import json
import os
from datetime import datetime

# Input and output file names
INPUT_FILE = "milk_collection_data.json"         # Replace with your actual input filename
OUTPUT_FILE = "filtered_output.json"

def load_json(file_path):
    """Load JSON data safely with logging."""
    if not os.path.exists(file_path):
        print(f"❌ Input file not found: {file_path}")
        return []
    with open(file_path, "r", encoding="utf-8") as f:
        data = json.load(f)
        print(f"📄 Loaded {len(data)} records from {file_path}")
        return data

def filter_and_adjust_dates(data):
    """Filter records for June and change month to September or October."""
    filtered = []
    for record in data:
        try:
            date_str = record.get("date")
            if not date_str:
                print(f"⚠ Skipping record with missing date: {record}")
                continue

            date = datetime.strptime(date_str, "%Y-%m-%d")

            # ✅ Only filter June (month == 6)
            if date.month == 5:
                new_month = 10 if date.day != 30 else 10
                adjusted_date = date.replace(month=new_month)
                record["date"] = adjusted_date.strftime("%Y-%m-%d")
                filtered.append(record)
                print(f"🗓 Converted {date_str} → {record['date']}")

        except Exception as e:
            print(f"❌ Error processing record {record}: {e}")
    print(f"✅ Filtered {len(filtered)} records from {len(data)} total")
    return filtered

def save_json(data, file_path):
    """Save JSON data with logging."""
    if not data:
        print("⚠ No records to save.")
        return
    with open(file_path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=4)
    print(f"💾 Saved filtered data to {file_path}")

if __name__ == "__main__":
    print("🚀 Starting JSON filtering process...")
    data = load_json(INPUT_FILE)
    filtered_data = filter_and_adjust_dates(data)
    save_json(filtered_data, OUTPUT_FILE)
    print("🏁 Process completed successfully.")