struct A { a : int }
struct B {a : int, b : A}

local C = struct { int }
local D = struct { double, C }

terra anon()
    var b : B
    b.a = 4
    b.b.a = 3
    
    var d : D
    d._0 = 1.0
    d._1._0 = 2
    
    b = d
    
    return b.a + b.b.a 
end

terra anon2()
    var b : B = { b = { 2.0 }, a = 4 }
    var b2 : B = { a = 4, { 2.0 } }
    var b3 : B = { 4, {2.0} }
    return b.a + b.b.a + b2.a + b2.b.a + b3.a + b3.b.a
end

terra anon3()
    return {5,{6}}
end

terra anon4()
    var b : B = anon3()
    return b.a + b.b.a
end
test = require("test")
test.eq(anon(),3)
test.eq(anon2(),18)
test.eq(anon4(),11)