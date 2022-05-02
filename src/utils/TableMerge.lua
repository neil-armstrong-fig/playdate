-- Taken from https://gist.github.com/qizhihere/cb2a14432d9bf65693ad?permalink_comment_id=4104319#gistcomment-4104319
function table.merge(table1, table2)
    if (table1 == nil) then
        return table2
    end
    if (table2 == nil) then
        return table1
    end

    for key, value in pairs(table2) do
        table1[key] = value
    end
    return table1
end