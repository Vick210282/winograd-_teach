#This file read CHIP.pr and comment all the power cells
file_name = "CHIP_pr.v"
print("edit IOVCC IOGNG in "+file_name+"...")
with open(file_name,"r") as f:
    newline=[]
    for word in f.readlines():        
        newline.append(word.replace("GNDIOC","//GNDIOC"))

with open(file_name,"w") as f:
    for line in newline:
        f.writelines(line)

with open(file_name,"r") as f:
    newline=[]
    for word in f.readlines():        
        newline.append(word.replace("VCC3IOC","//VCC3IOC"))  ## Replace the keyword while you copy.  

with open(file_name,"w") as f:
    for line in newline:
        f.writelines(line)

print("Done edit IOVCC IOGND...")