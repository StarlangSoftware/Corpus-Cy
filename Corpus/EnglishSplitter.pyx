from Language.EnglishLanguage cimport EnglishLanguage

cdef class EnglishSplitter(SentenceSplitter):

    cpdef str upperCaseLetters(self):
        """
        Returns English UPPERCASE letters.
        :return: English UPPERCASE letters.
        """
        return EnglishLanguage.UPPERCASE_LETTERS

    cpdef str lowerCaseLetters(self):
        """
        Returns English LOWERCASE letters.
        :return: English LOWERCASE letters.
        """
        return EnglishLanguage.LOWERCASE_LETTERS

    cpdef list shortCuts(self):
        """
        Returns shortcut words in English language.
        :return: Shortcut words in English language.
        """
        return ["dr", "prof", "org", "II", "III", "IV", "VI", "VII", "VIII", "IX",
                "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX",
                "XX", "min", "km", "jr", "mrs", "sir"]
