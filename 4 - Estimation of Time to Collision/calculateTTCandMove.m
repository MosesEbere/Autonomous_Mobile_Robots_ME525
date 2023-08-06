% Check if the robot is stationary and calculate the time to collision
if L1 == L2
    TTC = 0;
else
    % Calculate the time to collision using the formula
    TTC = (L1*deltaT)/abs(L1 - L2);
end

test_case = 1;
% Move the robot according to the cases
switch test_case
    case 1
        if TTC > 0 && TTC < 1
            stop(Rightmotor);
            stop(Leftmotor);
        end
    case 2
        tic
        while ~readButton(mylego, 'right')
            if TTC > 0 && TTC < 1
                stop(Rightmotor);
                stop(Leftmotor);
            
                speed = -10;

                Rightmotor.Speed = speed;
                Leftmotor.Speed = speed;
                start(Rightmotor);
                start(Leftmotor);
            end
        
            if TTC >= 10
                stop(Rightmotor);
                stop(Leftmotor);
            
                speed = 10;

                Rightmotor.Speed = speed;
                Leftmotor.Speed = speed;
                start(Rightmotor);
                start(Leftmotor);
            end
        end
    case 3
        stop(Rightmotor);
        stop(Leftmotor);
        if TTC > 0 && TTC < 1
            speed = -10;

            Rightmotor.Speed = speed;
            Leftmotor.Speed = speed;
            start(Rightmotor);
            start(Leftmotor);
        end
    case 4
        if TTC > 0 && TTC < 1
            stop(Rightmotor);
            stop(Leftmotor);
        
            speed = -10;

            Rightmotor.Speed = speed;
            Leftmotor.Speed = speed;
            start(Rightmotor);
            start(Leftmotor);
        end
    otherwise 
        warning('Unknown Case!')
end

