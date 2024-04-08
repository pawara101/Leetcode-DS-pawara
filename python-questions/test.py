s = "   fly me   to   the moon  "
split_s = s.split(' ')

print(split_s)
words_list =[]
for w in split_s:
    if len(w)  > 0:
        words_list.append(w)

print(len(words_list))