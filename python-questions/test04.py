def filter_words(words, letters):
    words_list = []
    for word in words:
        let_list = list(word)
        check_let_list = list(letters)
        contains_all = True
        for letter in check_let_list:
            if letter not in let_list:
                contains_all = False
                break
        if contains_all:
            words_list.append(word)
    return words_list

# Example usage:
filtered_words = filter_words(["apple", "banana", "orange", "grape"], "ae")
print(filtered_words)  # Output: ['apple', 'grape']


print(filter_words(["the","dog","a","bone"],"ae"))