return {
    func = function(type, iterations)
        if(not tonumber(iterations))then
            iterations = 5
        end
        iterations = tonumber(iterations)
        
        local done = false
        
        local function gracefulkeybind(key, ctrl, func)
            bindtokey(key, ctrl, func)
            table.insert(threadinstances, {
                Disconnect = function()
                    pcall(func)
                    keybinds[key] = nil
                end,
            })
        end
        
        local fractalobjects = {}
        local listlayout = console.SurfaceGui.ParentFrame.UIListLayout
        
        gracefulkeybind("c", true, function()
            for i = #fractalobjects, 1, -1 do
                if(i%200 == 0)then
                    task.wait()
                end
                pcall(game.Destroy, fractalobjects[i])
            end
            table.clear(fractalobjects)
            
            listlayout.Parent = console.SurfaceGui.ParentFrame
            done = true
        end)
        
        local function createFrame(size, position, color)
            local frame = Instance.new("Frame")
            frame.Size = size
            frame.Position = position
            frame.BackgroundColor3 = color
            frame.BorderSizePixel = 0
            frame.Parent = console.SurfaceGui.ParentFrame
            table.insert(fractalobjects, frame)
            return frame
        end
        
        local index = 0
        local function drawFractalTree(startPos, length, width, angle, depth, istrunk, last)
            index += 1
            if depth <= 0 then return end

            local trunk = createFrame(UDim2.new(0, width, 0, length), startPos, Color3.fromHSV(depth/iterations, 1, 1))
            trunk.AnchorPoint = Vector2.new(.5, 1)
            
            if(istrunk)then
                trunk.Rotation = 0
                trunk.Position = startPos
            else
                trunk.Rotation = angle
                trunk.Position = UDim2.fromScale(2 * (angle > 0 and 1 or -1), 0, 0, 0)
                trunk.Parent = last
            end
            
            if(index%150 == 0)then
                task.wait()
            end
            drawFractalTree(startPos, length*.7, width * .7, -angle, depth - 1, false, trunk)
            drawFractalTree(startPos, length*.7, width * .7, angle, depth - 1, false, trunk)
        end
        
        local function drawSierpinskiTriangle(p1, p2, p3, depth)
            index += 1
            if depth == 0 then
                local triangle = Instance.new("Frame")
                triangle.Size = UDim2.new(0, math.ceil(math.abs(p2.X - p1.X)), 0, math.ceil(math.abs(p3.Y - p1.Y)))
                triangle.Position = UDim2.new(0, p1.X, 0, p1.Y)
                triangle.BackgroundColor3 = Color3.fromHSV((index/255)%1, 1, 1)
                triangle.AnchorPoint = Vector2.new(0.5, 0.5)
                triangle.Rotation = math.deg(math.atan2(p3.Y - p1.Y, p2.X - p1.X))
                triangle.Parent = console.SurfaceGui.ParentFrame
                triangle.BorderSizePixel = 0
                table.insert(fractalobjects, triangle)
                return
            end

            local mid1 = Vector2.new((p1.X + p2.X) / 2, (p1.Y + p2.Y) / 2)
            local mid2 = Vector2.new((p2.X + p3.X) / 2, (p2.Y + p3.Y) / 2)
            local mid3 = Vector2.new((p1.X + p3.X) / 2, (p1.Y + p3.Y) / 2)
            
            if(index%100 == 0)then
                task.wait()
            end
            drawSierpinskiTriangle(p1, mid1, mid3, depth - 1)
            drawSierpinskiTriangle(mid1, p2, mid2, depth - 1)
            drawSierpinskiTriangle(mid3, mid2, p3, depth - 1)
        end
        
        local function drawMandelbrot(width, height, size)
            for x = 1, width do
                for y = 1, height do
                    local zx, zy = 0, 0
                    local cX = (x - width / 2) * 4 / width
                    local cY = (y - height / 2) * 4 / height
                    local i = 0

                    while(zx * zx + zy * zy < 4 and i < iterations)do
                        local tmp = zx * zx - zy * zy + cX
                        zy, zx = 2 * zx * zy + cY, tmp
                        i = i + 1
                    end
                    
                    if(i > 3 and i < iterations)then
                        local colorValue = Color3.fromHSV(i/iterations, 1, 1)
                        local frame = createFrame(UDim2.new(0, size, 0, size), UDim2.new(0,x*size, 0, y*size), colorValue)
                    end
                end
                task.wait()
            end
        end
        
        if(type == "tree")then
            listlayout.Parent = nil
            clearoutput()

            drawFractalTree(UDim2.new(0.5, 0, 1, 0), 200, 20, 25, iterations, true)
        elseif(type == "triangle")then
            listlayout.Parent = nil
            clearoutput()

            local points = {
                Vector2.new(400, 800),
                Vector2.new(800, 800),
                Vector2.new(600, 400)
            }
            drawSierpinskiTriangle(points[1], points[2], points[3], iterations)
        elseif(type == "mandelbrot")then
            listlayout.Parent = nil
            clearoutput()
            drawMandelbrot(300, 300, 3)
        else
            errortext("invalid fractal type. did you mean? (tree, triangle, mandelbrot)")
            return
        end
        
        repeat task.wait() until done
    end,
    description = "generates fractals"
}