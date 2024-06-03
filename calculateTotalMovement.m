% This function calculates the module of the total movement

function totalMovement = calculateTotalMovement(accX, accY, accZ)

    totalMovement = sqrt(accX.^2 + accY.^2 + accZ.^2);

end