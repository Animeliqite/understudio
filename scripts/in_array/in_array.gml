/// @description Returns true if `val` exists in array `arr`
/// @param array
/// @param value

function in_array(arr, val)
{
    for (var i = array_length(arr) - 1; i >= 0; i--)
        if (arr[i] == val)
            return true;
    return false;
}