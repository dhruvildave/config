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
    return line.trim().parse().unwrap();
}

fn read_vec<T>(r: &mut BufReader<Stdin>, n: usize) -> Vec<T>
where
    T: str::FromStr,
    <T as str::FromStr>::Err: fmt::Debug,
{
    let mut line = String::new();
    r.read_line(&mut line).unwrap();

    return line
        .trim()
        .splitn(n, ' ')
        .map(|x| {
            return x.parse().unwrap();
        })
        .collect();
}

fn write<T>(w: &mut BufWriter<Stdout>, x: T)
where
    T: fmt::Display,
{
    w.write(x.to_string().as_bytes()).unwrap();
}

fn write_vec<T>(w: &mut BufWriter<Stdout>, v: &Vec<T>, n: usize)
where
    T: fmt::Display,
{
    let mut l: Vec<String> = Vec::with_capacity(n);
    for i in &v[0..n] {
        l.push(i.to_string());
    }
    w.write(l.join(" ").as_bytes()).unwrap();
}

fn run(one_time: bool) {
    fn soln(r: &mut BufReader<Stdin>, w: &mut BufWriter<Stdout>) {}

    let r = &mut BufReader::new(io::stdin());
    let w = &mut BufWriter::new(io::stdout());

    if one_time {
        soln(r, w);
    } else {
        let n = read(r);
        for _ in 0..n {
            soln(r, w);
        }
    }
}

fn main() {
    const ONE_TIME: bool = true;

    run(!ONE_TIME);
}
