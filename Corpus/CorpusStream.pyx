from Corpus.AbstractCorpus cimport AbstractCorpus

cdef class CorpusStream(AbstractCorpus):

    def __init__(self, fileName=None):
        self.file_name = fileName

    cpdef open(self):
        self.file = open(self.file_name, "r", encoding='utf8')

    cpdef close(self):
        self.file.close()

    cpdef Sentence getNextSentence(self):
        cdef str line
        line = self.file.readline()
        if line:
            return Sentence(line.strip())
        else:
            return None

    cpdef list getSentenceBatch(self, int lineCount):
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
