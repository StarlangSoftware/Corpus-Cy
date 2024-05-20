from os.path import isfile


cdef class FileDescription:

    cpdef constructor1(self, str path, str fileName):
        """
        Constructor for the FileDescription object. FileDescription object is used to store sentence or tree file names
        in a format of path/index.extension such as 'trees/0123.train' or 'sentences/0002.test'. At most 10000 file names
        can be stored for an extension.
        :param path: Path of the file
        :param fileName: Raw file name of the string without path name, including the index of the file and the
                         extension. For example 0023.train, 3456.test, 0125.dev, 0000.train etc.
        """
        self.__path = path
        self.__extension = fileName[fileName.rindex('.') + 1:]
        self.__index = int(fileName[0: fileName.rindex('.')])

    cpdef constructor2(self, str path, str extension, int index):
        """
        Another constructor for the FileDescription object. FileDescription object is used to store sentence or tree
        file names in a format of path/index.extension such as 'trees/0123.train' or 'sentences/0002.test'. At most 10000
        file names can be stored for an extension.
        :param path: Path of the file
        :param extension: Extension of the file such as train, test, dev etc.
        :param index: Index of the file, should be larger than or equal to 0 and less than 10000. 123, 0, 9999, etc.
        :return:
        """
        self.__path = path
        self.__extension = extension
        self.__index = index

    def __init__(self,
                 path: str,
                 extensionOrFileName: str,
                 index: int = None):
        if index is None:
            self.constructor1(path, extensionOrFileName)
        else:
            self.constructor2(path, extensionOrFileName, index)

    cpdef str getPath(self):
        """
        Accessor for the path attribute.
        :return: Path
        """
        return self.__path

    cpdef int getIndex(self):
        """
        Accessor for the index attribute.
        :return: Index
        """
        return self.__index

    cpdef str getExtension(self):
        """
        Accessor for the extension attribute.
        :return: Extension
        """
        return self.__extension

    cpdef str getFileName(self,
                          thisPath=None,
                          extension=None):
        """
        Returns the filename with path and extensions are replaced with the given path and extension.
        :param thisPath: New path
        :param extension: New extension
        :return: The filename with path and extensions are replaced with the given path and extension.
        """
        if thisPath is None:
            thisPath = self.__path
        return self.getFileNameWithIndex(thisPath, self.__index, extension)

    cpdef str getFileNameWithExtension(self, str extension):
        """
        Returns the filename with extension replaced with the given extension.
        :param extension: New extension
        :return: The filename with extension replaced with the given extension.
        """
        return self.getFileName(self.__path, extension)

    cpdef str getFileNameWithIndex(self,
                                   str thisPath,
                                   int index,
                                   extension=None):
        """
        Returns the filename with path, index, and extension are replaced with the given path, index, and extension.
        :param thisPath: New path
        :param index: New Index
        :param extension: New extension
        :return: The filename with path, index, and extension are replaced with the given path, index, and extension.
        """
        if extension is None:
            extension = self.__extension
        return "%s/%04d.%s" % (thisPath, index, extension)

    cpdef str getRawFileName(self):
        """
        Returns only the filename without path as 'index.extension'.
        :return: File name without path as 'index.extension'.
        """
        return "%04d.%s" % (self.__index, self.__extension)

    cpdef addToIndex(self, int count):
        """
        Increments index by count
        :param count: Count to be incremented
        """
        self.__index += count

    cpdef nextFileExists(self,
                         int count,
                         thisPath=None):
        """
        Checks if the next file (found by changing the path and adding count to the index) exists or not. Returns true
        if it exists, false otherwise.
        :param count: Count to be incremented.
        :param thisPath: New path
        :return: Returns true, if the next file (found by changing the path and adding count to the index) exists,
        false otherwise.
        """
        if thisPath is None:
            thisPath = self.__path
        return isfile(self.getFileNameWithIndex(thisPath, self.__index + count))

    cpdef previousFileExists(self,
                             int count,
                             thisPath=None):
        """
        Checks if the previous file (found by changing the path and subtracting count from the index) exists or not.
        Returns true  if it exists, false otherwise.
        :param count: Count to be decremented.
        :param thisPath: New path
        :return: Returns true, if the previous file (found by changing the path and subtracting count to the index)
        exists, false otherwise.
        """
        if thisPath is None:
            thisPath = self.__path
        return isfile(self.getFileNameWithIndex(thisPath, self.__index - count))

    def __repr__(self):
        return f"{self.__path} {self.__index}.{self.__extension}"
