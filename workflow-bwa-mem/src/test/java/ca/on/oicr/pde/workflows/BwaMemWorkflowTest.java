/**
 * Copyright (C) 2015 Ontario Institute of Cancer Research
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * <p>
 * Contact us:
 * <p>
 * Ontario Institute for Cancer Research
 * MaRS Centre, West Tower
 * 661 University Avenue, Suite 510
 * Toronto, Ontario, Canada M5G 0A3
 * Phone: 416-977-7599
 * Toll-free: 1-866-678-6427
 * www.oicr.on.ca
 * <p>
 */
package ca.on.oicr.pde.workflows;

import ca.on.oicr.pde.testing.workflow.DryRun;
import ca.on.oicr.pde.testing.workflow.TestDefinition;
import net.sourceforge.seqware.pipeline.workflowV2.AbstractWorkflowDataModel;
import net.sourceforge.seqware.pipeline.workflowV2.model.AbstractJob;
import net.sourceforge.seqware.pipeline.workflowV2.model.SqwFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.io.FileUtils;
import org.testng.Assert;
import org.testng.annotations.Test;

import com.google.common.base.Joiner;

public class BwaMemWorkflowTest {

    public BwaMemWorkflowTest() {

    }

    @Test
    public void dryRunRegressionTests() throws IOException, Exception {
        TestDefinition td = TestDefinition.buildFromJson(FileUtils.readFileToString(new File("src/test/resources/tests.json")));
        for (TestDefinition.Test t : td.getTests()) {
            Map<String, String> params = new HashMap<>(t.getParameters());
            DryRun d = new DryRun(System.getProperty("bundleDirectory"), params, BwaMemWorkflow.class) {
            	AbstractWorkflowDataModel wfModel;

            	@Override
            	public AbstractWorkflowDataModel buildWorkflowModel() throws IllegalAccessException, Exception {
            	   wfModel = super.buildWorkflowModel();
            	   return wfModel;
            	}

            	@Override
            	public void validateWorkflow() {

            	  //check for null string
            	  for (AbstractJob j : wfModel.getWorkflow().getJobs()) {

            	      String c = Joiner.on(" ").useForNull("null").join(j.getCommand().getArguments());
            	      // support piping output to /dev/null for cutadapt log files
            	      // use with caution!
            	      c = c.replace("/dev/null", "/tmp/junk");
            	      //check for null string
                      Assert.assertFalse(c.contains("null"), "Warning: command contains \"null\":\n" + c + "\n");
            	      // check for missing spaces
            	      Assert.assertFalse(c.matches("(.*)[^ ]--(.*)"));
            	   }

            	   //view output files
            	   for (AbstractJob j : wfModel.getWorkflow().getJobs()) {
            	     for (SqwFile f : j.getFiles()) {
            	       if (f.isOutput()) {
            	           System.out.println(f.getProvisionedPath());
            	       }
            	     }
            	   }
            	}
            };
            
        }
    }
}
