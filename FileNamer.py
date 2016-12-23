import glob, os, enchant, re, collections, random

print(os.getcwd())

os.chdir(os.getcwd())

fileList = []

#Get all the files
for root, dirs, files in os.walk(os.getcwd()):
    for file in files:
        if file == "Main.asm":
            fileList.append(os.path.join(root, file))

existingNames = []
newpath = os.getcwd()+"/newFiles"

#Header informaiton
for path in fileList:
    print(path)
    #Open the File
    file = open(path)
    modifiedFile = []
    oldHeader = ""

    descriptionBegins = False
    codeBegins = False

    for line in file:
        if "INCLUDE" in line:
            codeBegins = True
        if codeBegins is False and descriptionBegins is True:
            oldHeader += line
        elif codeBegins is True:
            modifiedFile.append(line)

        if "Exercise" in line:
            descriptionBegins = True


    words = re.compile("\w+").findall(oldHeader)
    dict = enchant.Dict("en-US")

    badWords = ["program", "write", "following", "using", "integer", "assign", "section"]
    for word in words[:]:
        if len(word) < 4 or dict.check(word) is False or word.lower() in badWords:
            words.remove(word)

    wordFreq = collections.Counter(words)
    topTen = [x[0] for x in wordFreq.most_common(10)]

    numWords = random.randint(2, 3)
    chosenIndexes = []
    newName = ""

    wordConfirmed = False

    while wordConfirmed is False:
        while numWords > 0:
            temp = random.randint(0, len(topTen)-1)
            if temp not in chosenIndexes:
                chosenIndexes.append(temp)
                newName += str.title(topTen[temp])
                numWords -= 1

        if newName not in existingNames:
            existingNames.append(newName)
            wordConfirmed = True
        else:
            newName = ""
            numWords = random.randint(2, 3)


    modifiedFile.insert(0, ";Written by Tyler Wilding\n")
    modifiedFile.insert(1, ";" + newName + "\n")
    modifiedFile.insert(2, "\n")

    newFile = open(newpath+"/"+newName+".asm", "w+")

    newFileContents = ""
    for line in modifiedFile:
        newFileContents += line

    newFile.write(newFileContents)