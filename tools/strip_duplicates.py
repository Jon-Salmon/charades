import os

def remove_duplicate_lines_from_file(file_path):
    """
    Removes duplicate lines from a single file.
    :param file_path: Path to the text file to process.
    """
    try:
        with open(file_path, 'r') as file:
            lines = file.readlines()
        
        # Use a set to remove duplicates and preserve order
        seen = set()
        unique_lines = []
        for line in lines:
            if line not in seen:
                unique_lines.append(line)
                seen.add(line)

        # Rewrite the file with unique lines
        with open(file_path, 'w') as file:
            file.writelines(unique_lines)

        print(f"Processed: {file_path}")
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

def remove_duplicates_in_folder(folder_path):
    """
    Goes through all text files in the folder and removes duplicate lines.
    :param folder_path: Path to the folder containing text files.
    """
    if not os.path.isdir(folder_path):
        print(f"Invalid folder path: {folder_path}")
        return

    for root, _, files in os.walk(folder_path):
        for file in files:
            if file.endswith('.txt'):
                file_path = os.path.join(root, file)
                remove_duplicate_lines_from_file(file_path)

if __name__ == "__main__":
    remove_duplicates_in_folder("./assets/words")
