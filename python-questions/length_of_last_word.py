class Solution:
    def lengthOfLastWord(self, s: str) -> int:
        self.s = s

        split_s = s.split(' ')
        words_len = []
        if len(split_s) == 1:
            return len(split_s[0])
        else:
            words_list =[]
            for w in split_s:
                if len(w)  > 0:
                    words_list.append(w)
            
            return len(words_list[-1])


word = Solution()
print(word.lengthOfLastWord("   fly me   to   the moon  "))

