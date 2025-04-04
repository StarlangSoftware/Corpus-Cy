from Language.TurkishLanguage cimport TurkishLanguage

from Corpus.LanguageChecker cimport LanguageChecker
from Corpus.SentenceSplitter cimport SentenceSplitter


cdef class TurkishChecker(LanguageChecker):

    cpdef bint isValidWord(self, str word):
        """
        The isValidWord method takes an input String as a word than define all valid characters as a validCharacters
        string which has letters (abcçdefgğhıijklmnoöprsştuüvyzABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ),
        extended language characters (âàáäãèéêëíîòóôûúqwxÂÈÉÊËÌÒÛQWX),
        digits (0123456789),
        separators ({@literal ()[]{}"'״＂՛}),
        sentence enders (.?!…),
        arithmetic chars (+-=*\\),
        punctuation chars (,:;),
        special-meaning chars

        Then, loops through input word's each char and if a char in word does not in the validCharacters string it
        returns false, true otherwise.

        PARAMETERS
        ----------
        word : str
            String to check validity.

        RETURNS
        -------
        bool
            True if each char in word is valid, False otherwise.
        """
        cdef str special_meaning_characters, valid_characters
        cdef int i
        special_meaning_characters = "$\\_|@%#£§&><"
        valid_characters = TurkishLanguage.LETTERS + TurkishLanguage.EXTENDED_LANGUAGE_CHARACTERS + \
                           TurkishLanguage.DIGITS + SentenceSplitter.SEPARATORS + SentenceSplitter.SENTENCE_ENDERS + \
                           TurkishLanguage.ARITHMETIC_CHARACTERS + SentenceSplitter.PUNCTUATION_CHARACTERS + \
                           special_meaning_characters
        for i in range(len(word)):
            if word[i] not in valid_characters:
                return False
        return True
