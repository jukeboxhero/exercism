use  core::fmt::Debug;
#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(_first_list: &[T], _second_list: &[T]) -> Comparison {
    match [_first_list, _second_list] {
        [a, b] if a == b         => return Comparison::Equal,
        [[], _]                  => return Comparison::Sublist,
        [_, []]                  => return Comparison::Superlist,
        [a, b] if included(a, b) => return Comparison::Sublist,
        [a, b] if included(b, a) => return Comparison::Superlist,
        _                        => return Comparison::Unequal
    }
}

pub fn included<T: PartialEq>(a: &[T], b: &[T]) -> bool {
    return b.windows(a.len()).any(|letters| letters == a);
}
