from Corpus.AbstractCorpus cimport AbstractCorpus

cdef class CorpusStream(AbstractCorpus):

    def __init__(self, fileName=None):
        """
        Constructor for CorpusStream. CorpusStream is used for reading very large corpora that does not fit in memory as
        a whole. For that reason, sentences are read one by one.
        :param fileName: File name of the corpus stream.
        """
        self.file_name = fileName

    cpdef open(self):
        """
        Implements open method in AbstractCorpus. Initializes file reader.
        """
        self.file = open(self.file_name, "r", encoding='utf8')

    cpdef close(self):
        """
        Implements close method in AbstractCorpus. Closes the file reader.
        """
        self.file.close()

    cpdef Sentence getNextSentence(self):
        """
        Implements getSentence method in AbstractCorpus. Reads from the file buffer next sentence and returns it. If
        there are no sentences to be read, returns None.
        :return: Next read sentence from file buffer or None.
        """
        cdef str line
        line = self.file.readline()
        if line:
            return Sentence(line.strip())
        else:
            return None

    cpdef list getSentenceBatch(self, int lineCount):
        """
        Reads more than one line (lineCount lines) from the buffer, stores them in an array list and returns that
        array list. If there are no lineCount lines to be read, the method reads only available lines and returns them.
        :param lineCount: Maximum number of lines to read.
        :return: An array list of read lines.
        """
        cdef int i
        cdef str line
        sentences = []
        for i in range(lineCount):
            line = self.file.readline()
            if line:
                sentences.append(Sentence(line.strip()))
            else:
                break
        return sentences
