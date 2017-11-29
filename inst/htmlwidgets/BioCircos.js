HTMLWidgets.widget({

  name: 'BioCircos',

  type: 'output',

  factory: function(el, width, height) {

    // Define shared variables for this instance

    function objToArray(objectLiteral) {
      var piece1 = Object.keys(objectLiteral);
      var piece2 = Object.values(objectLiteral);
      var result = [];
      for (var i = 0; i < piece1.length; i++) {
        result.push([piece1[i], piece2[i]])
      }
      return result;
    }

    return {

      renderValue: function(x) {

        var opts = x // Rename variable

        el.innerText = opts.message; // Display input message

        d3.selectAll("p").style("color", "red"); // D3: paragraphs are now written in red

        var BioCircosGenome = objToArray(opts.genome);

        var maxRadius = Math.min(height, width)/2; // Compute maximal radial space

        // Adapt the radii from relative to absolute values
        for (var i = 0; i < opts.tracklist.length; i++) { // For each track
          opts.tracklist[i][1].maxRadius *= 0.7*maxRadius
          opts.tracklist[i][1].minRadius *= 0.7*maxRadius
        }

        BioCircos01 = new BioCircos(... opts.tracklist, BioCircosGenome,{
           target : el.id,
           svgWidth : width,
           svgHeight : height,
           chrPad : opts.chrPad,
           innerRadius: 0.7*maxRadius,
           outerRadius: 0.8*maxRadius,
           zoom : true,
           genomeFillColor: opts.genomeFillColor,
           CNVMouseOnDisplay : true,
           HEATMAPMouseOnDisplay : true,
           SNPMouseOnDisplay : true,
           FUSIONMouseOnDisplay: true,
           HISTOGRAMMouseOnDisplay: true,
           LINEMouseOnDisplay: true,
           genomeBorder : {
              display : opts.displayGenomeBorder,
              borderColor : opts.genomeBorderColor,
              borderSize : opts.genomeBorderSize
           },
           ticks : {
              display : opts.genomeTicksDisplay,
              len : opts.genomeTicksLen,
              color : opts.genomeTicksColor,
              textSize : opts.genomeTicksTextSize,
              textColor : opts.genomeTicksTextColor,
              scale : opts.genomeTicksScale
           },
           genomeLabel : {
              display : opts.genomeLabelDisplay,
              textSize : opts.genomeLabelTextSize,
              textColor : opts.genomeLabelTextColor,
              dx : opts.genomeLabelDx,
              dy : opts.genomeLabelDy
           }
        });

        BioCircos01.draw_genome(BioCircos01.genomeLength);
      },

      resize: function(width, height) {

        // code to re-render the widget with a new size

      }

    };
  }
});