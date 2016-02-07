// Customize this!
cubeSize = 0.75;
boardThickness = 0.1;

// TODO: Calculate this properly.
legHeight = 0.4;

// End customization

cubeSpacing = cubeSize / 10;
cubeFaceDiagonal = sqrt(2 * pow(cubeSize, 2));
cubeDiagonal = sqrt(3 * pow(cubeSize, 2));
boardLength = (2 * cubeFaceDiagonal) + cubeSpacing;

// theta is the angle of rotation in order to get the cubes to 
// balance on their points.
theta = asin(1 / sqrt(3));    
boardWidth = boardLength; //cubeSize * sqrt(2 / 3) * 2;

pedestalLength = boardLength;
pedestalWidth = boardWidth;
pedestalHeight = legHeight;

module balanced_cube(angle) {
  rotate([45, theta, angle]) {
    cube(size = cubeSize, center = true);
  }
}
  

difference() {
  union() {
    translate([
      -(boardLength / 2),
      -(boardWidth / 2),
      -(boardThickness)
    ]) {
      cube([
        boardLength,
        boardWidth,
        boardThickness]);
    }
    
    // Build the pedestal.
    difference() {
      translate([-(boardWidth / 2), -(boardLength / 2), -(boardThickness + legHeight)]) {
        cube([boardWidth, boardLength, legHeight]);
      }
      
      translate([-((boardWidth / 2) - boardThickness), -((boardLength / 2) - boardThickness), -(boardThickness + legHeight)]) {
        cube([boardWidth - (2 * boardThickness), boardLength - (2 * boardThickness), legHeight]);
      }
    }
    
    *difference() {
      translate([
        -(pedestalLength / 2),
        -(pedestalWidth / 2),
        -(boardThickness + pedestalHeight)
      ]) {
        cube([pedestalLength, pedestalWidth, pedestalHeight]);
      }

      // Subtract out the middle
      translate([
        -((pedestalLength / 2) - boardThickness),
        -((pedestalWidth / 2) - boardThickness),
        -(boardThickness + pedestalHeight)
      ]) {
        cube([
          (pedestalLength - (2 * boardThickness)),
          (pedestalWidth - (2 * boardThickness)),
          pedestalHeight]);
      }
    }
  }

  // Finally, the 4 dice. The "#" makes them visible in the preview, but
  // removes them from the rendering.
  #translate([0, 0, (cubeDiagonal / 2) * .67]) {
    delta = (cubeFaceDiagonal + cubeSpacing);
    
    translate([-(delta) / 2, delta / 2, 0]) {
      balanced_cube(-90);
    }
    
    translate([(delta) / 2, delta / 2, 0]) {
      balanced_cube(180);
    }
    
    translate([-(delta) / 2, -(delta / 2), 0]) {
      balanced_cube(0);
    }
    
    translate([(delta) / 2, -(delta / 2), 0]) {
      balanced_cube(90);
    }
  }
}
