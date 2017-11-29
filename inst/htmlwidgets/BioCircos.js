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
          opts.tracklist[i][1].BgouterRadius *= 0.7*maxRadius
          opts.tracklist[i][1].BginnerRadius *= 0.7*maxRadius
          opts.tracklist[i][1].x *= 0.7*maxRadius
          opts.tracklist[i][1].y *= 0.7*maxRadius
        }

        BioCircos01 = new BioCircos(... opts.tracklist, BioCircosGenome,{
          // Main configuration
          target : el.id,
          svgWidth : width,
          svgHeight : height,
          chrPad : opts.chrPad,
          innerRadius: 0.7*maxRadius,
          outerRadius: 0.8*maxRadius,
          zoom : opts.zoom, // Allow zoom and translation

          // SNP interaction options
          SNPMouseEvent : opts.SNPMouseEvent,
          SNPMouseClickDisplay : opts.SNPMouseClickDisplay,
          SNPMouseClickColor : opts.SNPMouseClickColor,
          SNPMouseClickCircleSize : opts.SNPMouseClickCircleSize,
          SNPMouseClickCircleOpacity : opts.SNPMouseClickCircleOpacity,
          SNPMouseClickCircleStrokeColor : opts.SNPMouseClickCircleStrokeColor,
          SNPMouseClickCircleStrokeWidth : opts.SNPMouseClickCircleStrokeWidth,
          SNPMouseClickTextFromData : opts.SNPMouseClickTextFromData,
          SNPMouseClickTextOpacity : opts.SNPMouseClickTextOpacity,
          SNPMouseClickTextColor : opts.SNPMouseClickTextColor,
          SNPMouseClickTextSize : opts.SNPMouseClickTextSize,
          SNPMouseClickTextPostionX : opts.SNPMouseClickTextPostionX,
          SNPMouseClickTextPostionY : opts.SNPMouseClickTextPostionY,
          SNPMouseClickTextDrag : opts.SNPMouseClickTextDrag,
          SNPMouseDownDisplay : opts.SNPMouseDownDisplay,
          SNPMouseDownColor : opts.SNPMouseDownColor,
          SNPMouseDownCircleSize : opts.SNPMouseDownCircleSize,
          SNPMouseDownCircleOpacity : opts.SNPMouseDownCircleOpacity,
          SNPMouseDownCircleStrokeColor : opts.SNPMouseDownCircleStrokeColor,
          SNPMouseDownCircleStrokeWidth : opts.SNPMouseDownCircleStrokeWidth,
          SNPMouseEnterDisplay : opts.SNPMouseEnterDisplay,
          SNPMouseEnterColor : opts.SNPMouseEnterColor,
          SNPMouseEnterCircleSize : opts.SNPMouseEnterCircleSize,
          SNPMouseEnterCircleOpacity : opts.SNPMouseEnterCircleOpacity,
          SNPMouseEnterCircleStrokeColor : opts.SNPMouseEnterCircleStrokeColor,
          SNPMouseEnterCircleStrokeWidth : opts.SNPMouseEnterCircleStrokeWidth,
          SNPMouseLeaveDisplay : opts.SNPMouseLeaveDisplay,
          SNPMouseLeaveColor : opts.SNPMouseLeaveColor,
          SNPMouseLeaveCircleSize : opts.SNPMouseLeaveCircleSize,
          SNPMouseLeaveCircleOpacity : opts.SNPMouseLeaveCircleOpacity,
          SNPMouseLeaveCircleStrokeColor : opts.SNPMouseLeaveCircleStrokeColor,
          SNPMouseLeaveCircleStrokeWidth : opts.SNPMouseLeaveCircleStrokeWidth,
          SNPMouseMoveDisplay : opts.SNPMouseMoveDisplay,
          SNPMouseMoveColor : opts.SNPMouseMoveColor,
          SNPMouseMoveCircleSize : opts.SNPMouseMoveCircleSize,
          SNPMouseMoveCircleOpacity : opts.SNPMouseMoveCircleOpacity,
          SNPMouseMoveCircleStrokeColor : opts.SNPMouseMoveCircleStrokeColor,
          SNPMouseMoveCircleStrokeWidth : opts.SNPMouseMoveCircleStrokeWidth,
          SNPMouseOutDisplay : opts.SNPMouseOutDisplay,
          SNPMouseOutAnimationTime : opts.SNPMouseOutAnimationTime,
          SNPMouseOutColor : opts.SNPMouseOutColor,
          SNPMouseOutCircleSize : opts.SNPMouseOutCircleSize,
          SNPMouseOutCircleOpacity : opts.SNPMouseOutCircleOpacity,
          SNPMouseOutCircleStrokeColor : opts.SNPMouseOutCircleStrokeColor,
          SNPMouseOutCircleStrokeWidth : opts.SNPMouseOutCircleStrokeWidth,
          SNPMouseUpDisplay : opts.SNPMouseUpDisplay,
          SNPMouseUpColor : opts.SNPMouseUpColor,
          SNPMouseUpCircleSize : opts.SNPMouseUpCircleSize,
          SNPMouseUpCircleOpacity : opts.SNPMouseUpCircleOpacity,
          SNPMouseUpCircleStrokeColor : opts.SNPMouseUpCircleStrokeColor,
          SNPMouseUpCircleStrokeWidth : opts.SNPMouseUpCircleStrokeWidth,
          SNPMouseOverDisplay : opts.SNPMouseOverDisplay,
          SNPMouseOverColor : opts.SNPMouseOverColor,
          SNPMouseOverCircleSize : opts.SNPMouseOverCircleSize,
          SNPMouseOverCircleOpacity : opts.SNPMouseOverCircleOpacity,
          SNPMouseOverCircleStrokeColor : opts.SNPMouseOverCircleStrokeColor,
          SNPMouseOverCircleStrokeWidth : opts.SNPMouseOverCircleStrokeWidth,

          SNPMouseOverTooltipsHtml01 : opts.SNPMouseOverTooltipsHtml01,
          SNPMouseOverTooltipsHtml02 : opts.SNPMouseOverTooltipsHtml02,
          SNPMouseOverTooltipsHtml03 : opts.SNPMouseOverTooltipsHtml03,
          SNPMouseOverTooltipsHtml04 : opts.SNPMouseOverTooltipsHtml04,
          SNPMouseOverTooltipsHtml05 : opts.SNPMouseOverTooltipsHtml05,
          SNPMouseOverTooltipsBorderWidth : opts.SNPMouseOverTooltipsBorderWidth,

          // Genome options
          genomeFillColor: opts.genomeFillColor,
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
          },
          TEXTModuleDragEvent : opts.TEXTModuleDragEvent
        });

        BioCircos01.draw_genome(BioCircos01.genomeLength);
      },

      resize: function(width, height) {

        // code to re-render the widget with a new size

      }

    };
  }
});