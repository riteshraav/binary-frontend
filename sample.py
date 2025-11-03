import json

# Read JSON file
with open('milk_collection_data.json', 'r') as file:
    data = json.load(file)

# Get unique customer IDs where adminId is 1
if isinstance(data, list):
    unique_customer_ids = {
        str(item['customerId'])
        for item in data
        if item.get('adminId') in ['1', 1] and 'customerId' in item
    }
else:
    unique_customer_ids = {
        str(data['customerId'])
    } if data.get('adminId') in ['1', 1] and 'customerId' in data else set()

# Print results
for customer_id in sorted(unique_customer_ids):
    print(customer_id)