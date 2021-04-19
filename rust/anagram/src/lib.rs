use std::collections::HashSet;
use std::collections::HashMap;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &'a [&str]) -> HashSet<&'a str> {
    possible_anagrams
        .iter()
        .filter(|anagram| is_anagram(word, anagram))
        .cloned()
        .collect()
}

pub fn is_anagram(word: &str, anagram: &str) -> bool{
    if word.chars().count() != anagram.chars().count() { return false; }
    if word.to_lowercase() == anagram.to_lowercase() { return false; }

    let mut frequencies = HashMap::new();
    for c in word.to_lowercase().chars() {
        let count = frequencies.entry(c).or_insert(0);
        *count += 1;
    }
    for c in anagram.to_lowercase().chars() {
        let count = frequencies.entry(c).or_insert(0);

        if count.clone() == 0 { return false; }
        
        *count -= 1;
    }

    return true;
}
