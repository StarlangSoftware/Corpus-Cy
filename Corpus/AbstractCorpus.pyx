cdef class AbstractCorpus(object):

    cpdef open(self):
        pass

    cpdef close(self):
        pass

    cpdef Sentence getNextSentence(self):
        pass
