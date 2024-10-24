//! Competitive Programming Template Code

#![allow(unused)]

use std::{
    fmt,
    io::{self, BufRead, BufReader, BufWriter, Stdin, Stdout, Write},
    str,
};

fn read<T>(r: &mut BufReader<Stdin>) -> T
where
    T: str::FromStr,
    <T as str::FromStr>::Err: fmt::Debug,
{
    let mut line = String::new();
    r.read_line(&mut line).unwrap();
    line.trim().parse().unwrap()
}

fn read_vec<T>(r: &mut BufReader<Stdin>, n: usize) -> Vec<T>
where
    T: str::FromStr,
    <T as str::FromStr>::Err: fmt::Debug,
{
    let mut line = String::new();
    r.read_line(&mut line).unwrap();

    let v = line
        .trim()
        .splitn(n, ' ')
        .map(|x| x.parse().unwrap())
        .collect::<Vec<T>>();
    assert_eq!(v.len(), n);
    v
}

fn write<T>(w: &mut BufWriter<Stdout>, x: T)
where
    T: fmt::Display,
{
    w.write_all(x.to_string().as_bytes()).unwrap();
}

fn write_vec<T>(w: &mut BufWriter<Stdout>, v: &[T], n: usize)
where
    T: fmt::Display,
{
    assert_eq!(v.len(), n);
    let l = v
        .iter()
        .map(|x| x.to_string())
        .collect::<Vec<_>>()
        .join(" ");
    w.write_all(l.as_bytes()).unwrap();
}

fn run(one_time: bool) {
    fn soln(r: &mut BufReader<Stdin>, w: &mut BufWriter<Stdout>) {}

    let r = &mut BufReader::new(io::stdin());
    let w = &mut BufWriter::new(io::stdout());

    let n = if one_time { 1 } else { read(r) };
    for _ in 0..n {
        soln(r, w);
    }
}

fn main() {
    const ONE_TIME: bool = true;
    run(!ONE_TIME);
}
