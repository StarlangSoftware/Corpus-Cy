from Corpus.AbstractCorpus cimport AbstractCorpus
from Corpus.Sentence cimport Sentence

cdef class CorpusStream(AbstractCorpus):

    cdef object file

    cpdef open(self)
    cpdef close(self)
    cpdef Sentence getNextSentence(self)
    cpdef list getSentenceBatch(self, int lineCount)
