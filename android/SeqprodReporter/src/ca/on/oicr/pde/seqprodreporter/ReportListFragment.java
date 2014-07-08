package ca.on.oicr.pde.seqprodreporter;

import java.util.Comparator;
import java.util.List;
import java.util.Locale;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.text.format.Time;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

public class ReportListFragment extends Fragment {

	/**
	 * The fragment argument representing the section number for this fragment.
	 */
	private ReportAdapter mAdapter;
	private Time lastUpdateTime;
	private int sectionNumber;
	
	private int sortingType;
	private String searchFilter;

    static final int SORT_BY_MODTIME   = 0;
    static final int SORT_BY_WORKFLOW = 1;
    static final int SORT_BY_SAMPLE  = 2;
    //May want to move these comparator's code into a separate class for easy maintenance            
	public final Comparator<Report> TIMECOMPARATOR = new ReportTimeComparator();
	public final Comparator<Report> SAMPLECOMPARATOR = new ReportNameComparator();
	public final Comparator<Report> NAMECOMPARATOR = new ReportWorkflowComparator();

	/**
	 * Returns a new instance of this fragment for the given section number.
	 */
	public static ReportListFragment newInstance(int sectionNumber) {
		ReportListFragment fragment = new ReportListFragment();
		fragment.setSectionNumber(sectionNumber);
		//fragment.setSearchFilter(null);
		return fragment;
	}

	public String getSearchFilter() {
		return searchFilter;
	}

	public void setSearchFilter(String searchFilter) {
		this.searchFilter = searchFilter;
	}

	@Override
	public void onSaveInstanceState(Bundle outState) {
		// We should save the sectionNumber here so that when the device is rotated, 
		// the app does not crash (May actually be unnecessary)
		super.onSaveInstanceState(outState);
		outState.putInt("sectionNumber", this.sectionNumber);
		//outState.pu("items", this.mAdapter.getAllItems());
	}

	
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		//TODO need to get View from savedInstanceState if setRetainInstance is not what we need
		if (null != savedInstanceState) {
			setSectionNumber(savedInstanceState.getInt("sectionNumber"));
			return super.onCreateView(inflater, container, savedInstanceState);
		}
		View rootView = inflater.inflate(R.layout.fragment_reporter, container,
				false);
		ListView listView = (ListView) rootView.findViewById(R.id.section_list);
			
		int index = this.getSectionNumber() - 1;
		this.mAdapter = new ReportAdapter(container.getContext(), R.layout.fragment_reporter);
		this.mAdapter.setNotifyOnChange(false);
		new JsonLoaderTask(this, ReporterActivity.types[index], this.lastUpdateTime).execute(getSearchFilter());

		listView.setAdapter(mAdapter);
		return rootView;
	}

	public void addLocalReports(List<Report> newReports) {
		this.mAdapter.removeAllViews();
		if (newReports.size() != 0){
			for (Report r : newReports) {
				this.mAdapter.add(r);
			}
			sortFragment();
		}
		else {
			String type = ReporterActivity.getType(this.sectionNumber-1);
			Report emptyReport = new Report(getString(R.string.empty_message) + " " + type ,Report.EMPTY_REPORT,"","","","","","",false);
			this.mAdapter.add(emptyReport);
		}
		mAdapter.notifyDataSetChanged();
	}

	//Invokes the correct comparator to sort a fragment's list
	//based on the 'sortingType' member variable that is set by the user
	public void sortFragment(){
		if (this.sortingType == SORT_BY_WORKFLOW){
			mAdapter.sortList(NAMECOMPARATOR);
		}
		else if (this.sortingType == SORT_BY_SAMPLE) {
			mAdapter.sortList(SAMPLECOMPARATOR);
		}
		else {
			mAdapter.sortList(TIMECOMPARATOR);
		}
	}

	public int getSectionNumber() {
		return this.sectionNumber;
	}
	
	public ReportAdapter getAdapter(){
		return this.mAdapter;
	}
	
	public void setSortIndex(int index){
		this.sortingType = index;
	}
	public void setLastUpdateTime(Time t) {
		this.lastUpdateTime = t;
	}

	private void setSectionNumber(int sectionNumber) {
		this.sectionNumber = sectionNumber;
	}

	// Comparators
	private class ReportNameComparator implements Comparator<Report> {
		public int compare(Report report1, Report report2) {

			String repSName1 = report1.getrSampleName().toUpperCase(
					Locale.getDefault());
			String repSName2 = report2.getrSampleName().toUpperCase(
					Locale.getDefault());

			// ascending order
			return repSName1.compareTo(repSName2);

		}
	};

	private class ReportWorkflowComparator implements Comparator<Report> {
		public int compare(Report report1, Report report2) {

			String repWName1 = report1.getrWorkflowName().toUpperCase(
					Locale.getDefault());
			String repWName2 = report2.getrWorkflowName().toUpperCase(
					Locale.getDefault());

			// ascending order
			return repWName1.compareTo(repWName2);

		}

	};

	private class ReportTimeComparator implements Comparator<Report> {
		public int compare(Report report1, Report report2) {

			Time repTime1 = report1.getTimeStamp();
			Time repTime2 = report2.getTimeStamp();

			// newer first
			return Time.compare(repTime2, repTime1);

		}

	};

}
