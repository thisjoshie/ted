package nu.ted.gwt.client;

import net.bugsquat.gwtsite.client.PageLoader;
import net.bugsquat.gwtsite.client.page.PageId;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.ui.Image;
import com.google.gwt.user.client.ui.RootPanel;

/**
 * Entry point classes define <code>onModuleLoad()</code>.
 */
public class GwtTed implements EntryPoint {

    /**
     * This is the entry point method.
     */
    public void onModuleLoad() {
        PageLoader.getInstance().loadPage(TedPageId.SEARCH);
    }
}
