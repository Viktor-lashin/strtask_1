import sequtils, strutils, os  # Все нужные библиотеки уже подключены
import utils  # Рекомендуем ознакомиться для выполнения задания :)

const RootDir = "folder"
# Ниже реализуйте требуемую задачу
var dirs, files, exts: seq[string]

var allFiles: seq[tuple[kind: PathComponent, path: string]]#тут буду хранить вообще все файлы и папки
#корневая пара, фолдер + его kind, начиная с корня остальное будет собираться
const Root : tuple[kind: PathComponent, path: string] = (pcDir, RootDir)
allFiles.add Root

var ind = 0
#будет добавлять в allFiles значения, пока находим новые папки. По сути - стек, только без операции удаления
while ind != allFiles.len:
    if allFiles[ind].kind == pcDir:
        #добавим в список всех файлов, файлы которые лежат в этой папке
        for entry in walkDir(allFiles[ind].path):
            allFiles.add entry
        #имя самой папки сразу кидаем в dirs, предварительно меняем пробел на _
        dirs.add allFiles[ind].path.replace(' ', '_')
    #Ежели сейчас данные - файл. То будем добавлять в файлы имя файла, а в exts расширения
    if allFiles[ind].kind == pcFile:
        let nowFile = allFiles[ind].path.split("\\")
        if nowFile[nowFile.len - 1][0] != '.':
            #чуть потеряли в эффективности из-за splitов, ну да ладно, задача не требовала большего
            files.add nowFile[nowFile.len - 1]
            exts.add '.' & nowFile[nowFile.len - 1].split('.')[nowFile[nowFile.len - 1].split('.').len - 1]
    ind += 1


# Не изменяйте код ниже
import sets
doAssert(
    len(@["folder/f_4/ff1", "folder/f_3/ff1", "folder/f_5", "folder/f_5/ff1", "folder/f_8", "folder/f_1", "folder/f_3", "folder", "folder/f_3/ff2", "folder/f_4", "folder/f_7", "folder/f_2", "folder/f_4/ff_2", "folder/f_6", "folder/f_9"].toHashSet - dirs.toHashSet) == 0 or
    len(@["folder\\f_4\\ff1", "folder\\f_3\\ff1", "folder\\f_5", "folder\\f_5\\ff1", "folder\\f_8", "folder\\f_1", "folder\\f_3", "folder", "folder\\f_3\\ff2", "folder\\f_4", "folder\\f_7", "folder\\f_2", "folder\\f_4\\ff_2", "folder\\f_6", "folder\\f_9"].toHashSet - dirs.toHashSet) == 0
)
doAssert len(@["file.4.some", "ff1.txt", "1.dat", "ff2.ext", "f3.text", "123.klm", "file.1.txt", "file.1.txt", "file.3.txt", "file.1.txt", "file.2.txt", "file 2.txt"].toHashSet - files.toHashSet) == 0
doAssert len(@[".some", ".txt", ".dat", ".txt", ".txt", ".txt", ".txt", ".text", ".klm", ".txt", ".ext", ".txt"].toHashSet - exts.toHashSet) == 0
