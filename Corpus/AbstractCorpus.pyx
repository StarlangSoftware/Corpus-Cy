cdef class AbstractCorpus:

    cpdef open(self):
        pass

    cpdef close(self):
        pass

    cpdef Sentence getNextSentence(self):
        pass
