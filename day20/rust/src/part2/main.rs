use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;
use std::time::Instant;

fn read_file<P>(path: P) -> io::Result<io::BufReader<File>>
where
    P: AsRef<Path>,
{
    let file = File::open(path)?;
    Ok(io::BufReader::new(file))
}

fn calculate(path: &str) -> String {
    let mut result: usize = 0;

    let lines = read_file(path).unwrap().lines();
    lines.for_each(|line_result| {
        let line = line_result.unwrap();

        // BEGIN TO DELETE
        result = line.len();
        // END TO DELETE
    });

    result.to_string()
}

fn main() {
    let start = Instant::now();
    let result = calculate("../input.txt");
    let duration = start.elapsed();

    println!("Result:\n{}", result.trim_end());
    println!("Execution time: {:?}", duration);
}

#[cfg(test)]
mod tests {
    use crate::calculate;

    #[test]
    fn it_works() {
        let expected = "fixme";
        let result = calculate("../example.txt");
        assert_eq!(result, expected);
    }
}
