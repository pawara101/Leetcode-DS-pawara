class Solution:
    def addTwoNumbers(self, l1, l2):
        self.l1 = l1
        self.l2 = l2

        sum_num =[0,0,0]
        addition_val = 0
        ## compare lengths
        if len(l1)== len(l2):
            for i in range(len(l2)):
                sum_digit = addition_val+l1[i]+l2[i]
                if sum_digit > 9:
                    sum_num[i] = sum_digit-10
                    addition_val = 1
                else:
                    sum_num[i] = sum_digit
                    addition_val = 0
            
        
            return sum_num

        elif len(l1) > len(l2):
            len_diff = len(l1) - len(l2)
            zeroes = [0] * len_diff

            l2_new = zeroes + l2
            for i in range(len(l2_new)):
                sum_digit = addition_val+l1[i]+l2_new[i]
                if sum_digit > 9:
                    sum_num[i] = sum_digit-10
                    addition_val = 1
                else:
                    sum_num[i] = sum_digit
                    addition_val = 0
            return l2_new


        else:
            len_diff = len(l2) - len(l1)
            zeroes = [0] * len_diff

            l1_new = zeroes + l1
            for i in range(len(l1_new)):
                sum_digit = addition_val+l1[i]+l1_new[i]
                if sum_digit > 9:
                    sum_num[i] = sum_digit-10
                    addition_val = 1
                else:
                    sum_num[i] = sum_digit
                    addition_val = 0
            return l1_new
        

x = Solution()
print(x.addTwoNumbers([2,4,3],[5,6,4]))