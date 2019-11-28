#include<iostream>
#include<string.h>
#include<vector>
using namespace std;

template <typename T>
class Graph {
    vector<T> graph[100];
public:
    int nodes;
    void addEdge (T const &a, T const &b){
        graph[a].push_back(b);
        graph[b].push_back(a);
    }
//    void deleteEdge (T const &a, T const &b);
//    bool isEdgeInGraph (T const &a, T const &b);
    void print(){
        for (int s=0; s<nodes; s++)
            for (int i=0; i<graph[s].size(); i++){
                cout << s << " " << graph[s][i] << endl;
            }
    }
    bool hamilton(){
        bool used[100];
        memset(used, 0, sizeof(used));
        used[0] = 1;
        return bck(0, 1, used);
    }

    bool bck (int s, int visitedNodes, bool used[]){
        cout << s << " " << visitedNodes << endl;

        if (visitedNodes == nodes) {
            return true;
        }

        for (int i=0; i<graph[s].size(); i++){
            if (!used[graph[s][i]]){
                cout << "unused\n";
                used[graph[s][i]] = 1;
                if (bck(graph[s][i], visitedNodes+1, used)){
                    return true;
                }
                used[graph[s][i]] = 0;
            }
        }

        return false;
    }
};

int main (){
    int M;
    Graph<int> graph;
    cin >> graph.nodes >> M;

    int a, b;
    for (int i=0; i<M; i++){
        cin >> a >> b;
        graph.addEdge(a, b);
    }

    cout << graph.hamilton() << endl;
    return 0;
}
