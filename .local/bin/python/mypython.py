
# =====================================
# Byte conversions
def kilo(num : int):
    return num*1024
def mega(num : int):
    return num*1024*1024
def giga(num : int):
    return num*1024*1024*1024
def tera(num : int):
    return num*1024*1024*1024*1024
def hexk(num : int):
    return hex(kilo(num))
def hexm(num : int):
    return hex(mega(num))
def hexg(num : int):
    return hex(giga(num))
def hext(num : int):
    return hex(tera(num))
# =====================================

# =====================================
# Graphics helpers
import struct

def hex_to_f32(hex_str : str):
    hex_str = hex_str.strip().replace("0x", "")
    byte_array = bytes.fromhex(hex_str)
    float_num : float = struct.unpack('!f', byte_array)[0]
    return float_num

# =====================================

def main():
    hex_to_test = "0x428bFAE1"
    converted : str = hex_to_f32(hex_to_test)
    print(converted)

if __name__ == "__main__":
    main()

