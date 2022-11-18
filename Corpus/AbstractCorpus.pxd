from Corpus.Sentence cimport Sentence

cdef class AbstractCorpus:

    cdef str file_name

    cpdef open(self)
    cpdef close(self)
    cpdef Sentence getNextSentence(self)
