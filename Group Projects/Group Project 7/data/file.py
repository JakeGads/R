from glob import glob
for i in glob("*.csv"):
        print(f"\"data/{i}\",")
