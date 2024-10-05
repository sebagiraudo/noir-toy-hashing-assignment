global PRIME: u32 = 16777619;

fn main(value: u32, hash_value: pub u32){
    let calculated_hash_value = calculate_hash(value);

    assert(calculated_hash_value == hash_value);
}

// Python version:
// size = 2**32
// hash_value = 0x811C9DC5
// prime = 0x1000193

// for byte in data:
//     product = (hash_value * prime) % size
//     hash_value = (product ^ byte)

// return hash_value
fn calculate_hash(num: u32) -> u32 {
    let mut hash_value: u64 = 0x811C9DC5;
    let prime: u32 = 0x1000193;
    // transform the num variable to array of bytes
    // first convert it to Field type
    let bytes: [u8] = (num as Field).to_be_bytes(4);
    let size: u64 = 0x100000000;

    for byte in bytes {
        // RHS and LHS must be the same type
        let product = (hash_value * prime as u64) % size;
        hash_value = product ^ (byte as u64);
    }
    // return parsed as u32
    hash_value as u32
}

#[test]
fn test_1() {
    let num = 127561628;
    let hash = calculate_hash(num);
    
    assert(hash == 0x71233de7);
}

#[test]
fn test_2() {
    let num = 237261828;
    let hash = calculate_hash(num);

    assert(hash == 0x7F51D567);
}

#[test]
fn test_3() {
    let num = 596214892;
    let hash = calculate_hash(num);

    assert(hash == 0x3F0C8995);
}
