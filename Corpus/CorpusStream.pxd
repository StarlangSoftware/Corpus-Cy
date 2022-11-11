from Corpus.Sentence cimport Sentence

cdef class CorpusStream:

    cdef str file_name
    cdef object file

    cpdef open(self)
    cpdef close(self)
    cpdef Sentence getSentence(self)
    cpdef list getSentenceBatch(self, int lineCount)
