# class Solution(object):
#     def convert(self, s, numRows):
#         """
#         :type s: str
#         :type numRows: int
#         :rtype: str
#         """
#         self.s = s
#         self.numRows = numRows
        
s = "PAYPALISHIRING"
r = 3

s_rows = [(s[i:i+r]) for i in range(0, len(s), r)]

