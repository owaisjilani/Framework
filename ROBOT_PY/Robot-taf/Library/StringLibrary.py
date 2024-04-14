import re
class StringLibrary:
    def remove_binary_and_uuid(self, input_string):
        # substitute Binary and UUID with blank
        output_string = re.sub(r'(?i)(Binary|UUID)\([^)]+\)', '', input_string)
        return output_string
