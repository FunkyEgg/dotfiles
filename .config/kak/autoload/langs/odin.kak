# Source: https://github.com/FunkyEgg/dotfiles/.config/kak/autoload/langs/odin.kak
# Note: worst highlighter known to mankind

# Detection
hook global BufCreate .+\.odin %{
    set-option buffer filetype odin
}

# Init
hook global WinSetOption filetype=odin %{
    require-module odin
    add-highlighter window/odin ref odin
}

# Deinit
hook global WinSetOption filetype=(?!odin).* %{
    remove-highlighter window/odin
}

# Highlighting
provide-module odin %{
    add-highlighter shared/odin regions
    add-highlighter shared/odin/code default-region group

    add-highlighter shared/odin/code/keywords regex \b(asm|auto_cast|bit_set|break|case|cast|context|continue|defer|distinct|do|dynamic|else|enum|fallthrough|for|foreign|if|import|in|map|not_in|or_else|or_return|package|proc|return|struct|switch|transmute|typeid|union|using|when)\b 1:keyword
	add-highlighter shared/odin/code/types regex \b(byte|bool|b8|b16|b32|b64|i8|i16|i32|i64|i128|u8|u16|u32|u64|u128|rune|f16|f32|f64|complex32|complex64|complex128|quaternion64|quaternion128|quaternion256|int|uint|uintptr|rawptr|string|cstring|any|typeid|i16le|i32le|i64le|i128le|u16le|u32le|u64le|u128le|i16be|i32be|i64be|i128be|u16be|u32be|u64be|u128be|f16le|f32le|f64le|f16be|f32be|f64be)\b 1:type

	add-highlighter shared/odin/code/builtin_variables regex \b(ODIN_\w+)\b 1:value
	add-highlighter shared/odin/code/builtin_procs regex \b(len|cap|size_of|align_of|offset_of_selector|offset_of_member|offset_of|offset_of_by_string|type_of|type_info_of|typeid_of|swizzle|complex|quaternion|real|imag|jmag|kmag|conj|expand_value|min|max|abs|clamp|soa_zip|soa_unzip)\b 1:meta
	add-highlighter shared/odin/code/hash_thingos regex "#([a-z]|[A-Z])*" 0:builtin
	add-highlighter shared/odin/code/functions regex (?<=\.)([a-z]|[A-Z])([a-z]|[A-Z]|[0-9])* 0:function

	add-highlighter shared/odin/code/bool_value regex \b(true|false|nil)\b 1:value
	add-highlighter shared/odin/code/number regex \b[0-9]+.[0-9]+\b 0:value
	add-highlighter shared/odin/code/bool regex \b0b[0-1]+\b 0:value
	add-highlighter shared/odin/code/octal regex \b0o[0-8]+\b 0:value
	add-highlighter shared/odin/code/hex regex \b0x([0-9]|[a-f]|[A-F])+\b 0:value

	add-highlighter shared/odin/string region \" \" fill string
	add-highlighter shared/odin/char region \' \' fill string

	add-highlighter shared/odin/code/line_comment regex (?S)//.* 0:comment
	add-highlighter shared/odin/comment region /\* \*/ fill comment
}
