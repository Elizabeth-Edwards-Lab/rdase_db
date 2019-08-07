



file = open("2019_08_07_11_08_35.phy").readlines()

compact = ""
for line in file:
	compact += line.replace("\n","")
file_write = open("compactfile.txt","w")
file_write.write(compact)

file.close()
file_write.close()

print(compact)