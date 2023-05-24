import os
import xml.etree.ElementTree as ET
import json

def parse_xml_to_dict(element):
    if element.text and element.text.strip():
        text_value = element.text.strip()
    else:
        text_value = None

    if len(element) > 0:
        data = {f"@{k}": v for k, v in element.attrib.items()}  # Prefix each attribute key with "@"
        for child in element:
            child_data = parse_xml_to_dict(child)
            if child.tag in data:
                if type(data[child.tag]) is list:
                    data[child.tag].append(child_data)
                else:
                    data[child.tag] = [data[child.tag], child_data]
            else:
                data[child.tag] = child_data
        return data
    else:
        return text_value or {f"@{k}": v for k, v in element.attrib.items()}

# Path to the folder containing XML files
xml_folder = '/Users/pericepope/Downloads/XML'

# Iterate through XML files in the folder
for file_name in os.listdir(xml_folder):
    if file_name.endswith('.xml'):
        xml_file = os.path.join(xml_folder, file_name)
        
        # Parse the XML file
        tree = ET.parse(xml_file)
        root = tree.getroot()

        # Convert XML to dictionary
        xml_data = parse_xml_to_dict(root)

        # Convert dictionary to JSON
        json_data = json.dumps(xml_data, indent=4)

        # Output JSON file name
        json_file = os.path.join(xml_folder, os.path.splitext(file_name)[0] + '.json')

        # Write the JSON data to a file
        with open(json_file, 'w') as file:
            file.write(json_data)

        print(f'Conversion complete for {file_name}. JSON file generated:', json_file)
