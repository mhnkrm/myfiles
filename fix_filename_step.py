import os
import re

class rename_files():

    root = "D:\\MobaXterm\\moba_home\\slash\\data\\alm_mask\\" \
           "Warriorspace\\Testcases\\t310_prefit_oc192"
    path = os.path.join(root, "targetdirectory")


    def __init__(self):
        self.file_list = []

    def get_file_list(self):
        for path, subdirs, files in os.walk(self.root):
            for name in files:
                self.file_list.append(os.path.join(path, name))

    def change_file_name(self):
        self.get_file_list()
        for file_path in self.file_list:
            file = open(file_path,'r+')
            file_name = self.get_file_name(file_path)
            file_title = self.file_title(file_name)
            print "File's Changed : {}".format(file_name)
            file_content = file.readlines()
            file.close()
            file_write = open(file_path, 'w+')
            contents = self.change_name_step(file_content,file_name,file_title)
            file_write.write(contents)
            file.close()


    def change_name_step(self,file_content,file_name,file_title):
        step_number = 1
        test_contents = ""
        for contents in file_content:
            if "Name" in contents:
                contents_replace = "<Name>{}</Name>".format(file_name)
                contents_test = re.sub('<\w+>.*</\w+>',contents_replace,contents)
                test_contents += contents_test
            elif "Title" in contents:
                contents_replace = "<Title>{}</Title>".format(file_title)
                contents_test = re.sub('<\w+>.*</\w+>', contents_replace, contents)
                test_contents += contents_test
            elif "TS" in contents:
                content_replace = 'TS="{}"'.format(step_number)
                contents_test = re.sub('TS="\d+"',content_replace,contents)
                test_contents += contents_test
                step_number += 1
            else:
                test_contents += contents
        return test_contents





    def get_file_name(self,file_path):
        file_name = file_path.split("\\")[-1].replace(".xml","")
        return file_name

    def file_title(self,file_name):
        file_title = file_name.upper().replace("_"," ")
        return file_title


rename = rename_files()
rename.change_file_name()