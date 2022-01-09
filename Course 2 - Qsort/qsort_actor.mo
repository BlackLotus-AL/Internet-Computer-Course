import Array "mo:base/Array";
import Int "mo:base/Int";
import Iter "mo:base/Iter";

actor{
    public shared({caller}) func qsort(arr : [Int]) : async [Int]{
        if(Iter.size<Int>(Array.vals<Int>(arr)) == 0){
            return [];
        };
        var re0_arr = Array.make<Int>(arr[0]);
        re0_arr := Array.append<Int>(re0_arr, arr);
        var tmp_arr : [var Int] = Array.thaw<Int>(re0_arr);
        sort(tmp_arr, 1, Iter.size<Int>(Array.vals<Int>(arr)));
        var ans_arr : [Int] = [];
        for(i in Iter.range(1, Iter.size<Int>(Array.vals<Int>(arr)))){
            ans_arr := Array.append<Int>(ans_arr, Array.make<Int>(tmp_arr[i]));
        };
        ans_arr
    };

    private func sort(s : [var Int], start : Nat, end : Nat) : (){
        var i = start;
        var j = end;
        s[0] := s[start];
        while(i < j){
            while(i < j and s[0] < s[j]){
                j := j - 1;
            };
            if(i < j){
                s[i] := s[j];
                i := i + 1;
            };
            while(i < j and s[i] <= s[0]){
                i := i + 1;
            };
            if(i < j){
                s[j] := s[i];
                j := j - 1;
            };
        };
        s[i] := s[0];
        if(start < i){
            sort(s, start, j - 1);
        };
        if(i < end){
            sort(s, j + 1, end);
        };
    };
}