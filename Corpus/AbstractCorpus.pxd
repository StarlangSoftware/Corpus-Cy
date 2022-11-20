from Corpus.Sentence cimport Sentence

cdef class AbstractCorpus(object):

    cdef str file_name

    cpdef open(self)
    cpdef close(self)
    cpdef Sentence getNextSentence(self)
